using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ServiceNowWCF
{
    public class Record
    {
        public string name {get; set;}
        public string shortDescription { get; set; }   
        public string category { get; set; }
        public JournalEntry comments { get; set; }
        public string description { get; set; }
        public string impact { get; set; }
        public int impact_val { get; set; }
        public string openDate { get; set; }
        public string closeDate { get; set; }
        public string state { get; set; }
        public string systemId { get; set; }

        public Record()
        {
            name = "";
            shortDescription = "";
            category = "";
            comments = new JournalEntry();
            description = "";
            systemId = "";
            openDate = "";
            closeDate = "";
            impact = "";
            state = "";
            impact_val = -1;
        }

        public void setName(string n) {
            name = n;
        }
    }
}