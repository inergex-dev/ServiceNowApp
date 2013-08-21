using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ServiceNowWCF
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // IMPORTANT: When adding a new method, must add the prototype to IService.cs file
    public class ServiceNow : IServiceNow
    {
        private const string ALL = "ALL_TICKETS";
        private const string OPENED = "ALL_OPENED_TICKETS";
        private const string CLOSED = "ALL_CLOSED_TICKETS";

        public string GetData(int value)
        {
            return string.Format("You passed in: {0}", value);
        }

        // For debugging login failures
        //public string loginDebug(string username, string password)
        //{
        //    // CREATE CLIENT AND AUTHENTICATE
        //    ServiceNowReference.ServiceNowSoapClient client = new ServiceNowReference.ServiceNowSoapClient();
        //    client.ClientCredentials.UserName.UserName = username;
        //    client.ClientCredentials.UserName.Password = password;

        //    // TRY LOGIN CREDENTIALS, CALLING AN ARBITRARY FUNCTION TO TEST THE CONNECTION
        //    ServiceNowReference.get get = new ServiceNowReference.get();
        //    ServiceNowReference.getResponse getResponse = new ServiceNowReference.getResponse();
        //    get.sys_id = "FOO BAR";

        //    try
        //    {
        //        getResponse = client.get(get); // try making some arbitrary call to Service Now to test the credentials
        //        return "LOGIN SUCCESS!"; // Able to make a web service call with their credentials
        //    }
        //    catch (Exception e)
        //    {
        //        return "LOGIN FAIL" + " | Details: " + e.Message; // Exception thrown if login credentials were invalid
        //    }            
        //}

        // Test the client credentials and return success or failure
        public bool login(string username, string password)
        {
            // CREATE CLIENT AND AUTHENTICATE
            ServiceNowReference.ServiceNowSoapClient client = createClient(username, password);

            // TRY LOGIN CREDENTIALS, CALLING AN ARBITRARY FUNCTION TO TEST THE CONNECTION
            ServiceNowReference.get get = new ServiceNowReference.get();
            ServiceNowReference.getResponse getResponse = new ServiceNowReference.getResponse();
            get.sys_id = "FOO BAR";

            try
            {
                getResponse = client.get(get); // try making some arbitrary call to Service Now to test the credentials
                return true; // Able to make a web service call with their credentials
            }
            catch (Exception e)
            {
                return false; // Exception thrown if login credentials were invalid
            }
        }

        public Record[] getAll(string username, string password)
        {          
            return getRecordsOfType(username, password, ALL);
        }
        

        public Record[] getOpened(string username, string password) {
            return getRecordsOfType(username, password, OPENED);
        }

        public Record[] getClosed(string username, string password) {
            return getRecordsOfType(username, password, CLOSED);
        }

        private Record[] getRecordsOfType(string username, string password, string condition) {
            // CREATE CLIENT AND AUTHENTICATE
            ServiceNowReference.ServiceNowSoapClient client = createClient(username, password);
            
            // GET RECORDS
            ServiceNowReference.getRecords snRecords = new ServiceNowReference.getRecords();
            ServiceNowReference.getRecordsResponse snRecordsResponse = new ServiceNowReference.getRecordsResponse();
            try
            {
                ServiceNowReference.getRecordsResponseGetRecordsResult[] snResponse = client.getRecords(snRecords); // Get all records
                int length = snResponse.Length;

                // CREATE A NEW ARRAY OF RECORDS HOLDING ONLY THE PERTINENT INFORMATION
                Record[] records = new Record[length];
                for (int i = 0; i < length; i++)
                {
                    switch (condition)
                    {
                        case ALL:
                            records[i] = loadRecordAtIndex(snResponse, i, username, password);
                            break;
                        case OPENED:
                            // Check if ticket is opened and return if needed
                            if (snResponse.ElementAt(i).active)
                                records[i] = loadRecordAtIndex(snResponse, i, username, password);
                            break;
                        case CLOSED: 
                            if (!snResponse.ElementAt(i).active)
                                records[i] = loadRecordAtIndex(snResponse, i, username, password);
                            break;
                        default:
                            // ERROR CALLING HELPER FUNCTION, MUST PROVIDE EITHER ALL, OPENED, OR CLOSED PARAMETER...
                            records[i] = loadRecordAtIndex(snResponse, i, username, password);
                            break;
                    }                    
                }
                return records;
            }
            catch (Exception e)
            {
                String debug = e.Message;
                return null;
            }            
        }

        // LOAD RECORD FROM SNRESPONSE OBJECT AT A GIVEN INDEX
        private Record loadRecordAtIndex(ServiceNowReference.getRecordsResponseGetRecordsResult[] snResponse, int i, string username, string password)
        {
            Record r = new Record();
            r = new Record();

            // Any updates here should also be mirrored in getRecordFromResponse!
            r.name = snResponse.ElementAt(i).sys_class_name;
            r.shortDescription = snResponse.ElementAt(i).short_description;
            r.systemId = snResponse.ElementAt(i).sys_id;
            r.openDate = snResponse.ElementAt(i).opened_at;
            r.closeDate = snResponse.ElementAt(i).closed_at;
            r.impact = snResponse.ElementAt(i).impact;
            r.impact_val = int.Parse(r.impact.Substring(0, 1));
            r.state = snResponse.ElementAt(i).state;
            r.category = snResponse.ElementAt(i).category;
            r.comments = getJournalEntries(username, password, r.systemId);
            r.description = snResponse.ElementAt(i).description;            

            return r;
        }

        // LOAD RECORD FROM GETRESPONSE OBJECT
        private Record getRecordFromResponse(ServiceNowReference.getResponse getResponse, string username, string password)
        {
            Record r = new Record();
            r = new Record();

            // Any updates here should also be mirrored in loadRecordAtIndex!
            r.name = getResponse.sys_class_name;
            r.shortDescription = getResponse.short_description;
            r.systemId = getResponse.sys_id;
            r.openDate = getResponse.opened_at;
            r.closeDate = getResponse.closed_at;
            r.impact = getResponse.impact;
            r.impact_val = int.Parse(r.impact.Substring(0, 1));
            r.state = getResponse.state;
            r.category = getResponse.category;
            r.comments = getJournalEntries(username, password, getResponse.sys_id);
            r.description = getResponse.description;
            
            return r;
        }
            
        // GIVEN A SYSTEM ID, RETURN THE CORRESPONDING RECORD
        public Record getRecord(string username, string password, string systemId)
        {
            // CREATE CLIENT AND AUTHENTICATE
            ServiceNowReference.ServiceNowSoapClient client = createClient(username, password);

            // VARIABLES TO GET THE RECORD
            ServiceNowReference.get get = new ServiceNowReference.get();
            ServiceNowReference.getResponse getResponse = new ServiceNowReference.getResponse();
            get.sys_id = systemId;
            Record record = new Record();

            // GET THE RECORD
            try
            {
                getResponse = client.get(get);
                record = getRecordFromResponse(getResponse, username, password);
                return record;
                
            }
            catch (Exception)
            {
                return record;
            }
        }

        

        public bool createTicket(string username, string password, string name, string category, string shortDescription, string description, string comments) {
            // CREATE CLIENT AND AUTHENTICATE
            ServiceNowReference.ServiceNowSoapClient client = createClient(username, password);

            // BUILD INSERT MESSAGE
            ServiceNowReference.insert insert = new ServiceNowReference.insert();
            ServiceNowReference.insertResponse response = new ServiceNowReference.insertResponse();
            insert.category = category;
            insert.short_description = shortDescription;
            insert.description = shortDescription;
            insert.comments = comments;

            // SEND MESSAGE
            try
            {
                response = client.insert(insert);
                // Return Values Available: 
                //    string incidentNumber = response.number;
                //    string systemId = response.sys_id;
                //    string responseString = response.ToString();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        // GET THE JOURNAL ENTRY FOR A SPECIFIC SYS_ID VALUE
        public JournalEntry getJournalEntries(string username, string password, string systemId)
        {
            try
            {
                // Create Journal Client
                JournalTableServiceNowReference.ServiceNowSoapClient client = new JournalTableServiceNowReference.ServiceNowSoapClient("ServiceNowSoap1");
                client.ClientCredentials.UserName.UserName = username;
                client.ClientCredentials.UserName.Password = password;

                // Custom code to call journal entries from the journal table            
                JournalTableServiceNowReference.getRecords records = new JournalTableServiceNowReference.getRecords();
                JournalTableServiceNowReference.getRecordsResponseGetRecordsResult[] response;
                //records.sys_id = systemId;
                records.element_id = systemId;
                response = client.getRecords(records);
                
                JournalEntry entries = new JournalEntry();
                for (int i = 0; i < response.Length; i++) 
                    entries.addComment(response.GetValue(i).ToString());
                return entries;
            }
            catch (Exception)
            {
                return new JournalEntry(); 
            }
        }

        private ServiceNowReference.ServiceNowSoapClient createClient(string username, string password)
        {
            ServiceNowReference.ServiceNowSoapClient client = new ServiceNowReference.ServiceNowSoapClient();
            client.ClientCredentials.UserName.UserName = username;
            client.ClientCredentials.UserName.Password = password;
            return client;
        }            

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }
    }
}