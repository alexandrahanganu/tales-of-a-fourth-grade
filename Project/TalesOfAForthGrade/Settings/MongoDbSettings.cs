namespace TalesOfAForthGrade.Settings
{
    public class MongoDbSettings{
        public string URL {get; set;}

        public string ConnectionString
        {
            get{
                return URL;
            }
        }
    }
}