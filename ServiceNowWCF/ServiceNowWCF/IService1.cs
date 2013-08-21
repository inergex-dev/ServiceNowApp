using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ServiceNowWCF
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IServiceNow
    {

        [OperationContract]
        string GetData(int value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here        
        [OperationContract]
        [WebInvoke]
        bool login(string username, string password);

        //[OperationContract]
        //[WebInvoke]
        //string loginDebug(string username, string password);

        [OperationContract]
        [WebInvoke]
        bool createTicket(string username, string password, string name, string category, string shortDescription, string description, string comments);

        [OperationContract]
        [WebInvoke]
        Record[] getAll(string username, string password);

        [OperationContract]
        [WebInvoke]
        Record[] getOpened(string username, string password);

        [OperationContract]
        [WebInvoke]
        Record[] getClosed(string username, string password);

        [OperationContract]
        [WebInvoke]
        Record getRecord(string username, string password, string systemId);

        [OperationContract]
        [WebInvoke]
        JournalEntry getJournalEntries(string username, string password, string systemId);
    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }
}
