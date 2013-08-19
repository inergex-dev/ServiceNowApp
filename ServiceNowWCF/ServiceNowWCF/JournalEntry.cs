using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ServiceNowWCF
{
    public class JournalEntry
    {
        List<string> comments; // = new List<string>();        
        public JournalEntry() { List<string> comments = new List<string>(); }
        public string getComment(int i) { return comments.ElementAt(i); }
        public List<string> getAllComments() { return comments; }
        public void addComment(string c) { comments.Add(c); }
    }
}