using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using TalesOfAForthGrade.Api.Entities;

namespace TalesOfAForthGrade.Api.Repositories
{
    public class MongoDbSubjectRepository : ISubjectsRepository
    {

        private const string databaseName = "ToaFG";
        private const string collectionName = "subjects";
        private readonly IMongoCollection<Subject> subjectsCollection;
        private readonly FilterDefinitionBuilder<Subject> filterBuilder = Builders<Subject>.Filter;

        public MongoDbSubjectRepository(IMongoClient mongoClient){
            IMongoDatabase database = mongoClient.GetDatabase(databaseName);
            subjectsCollection = database.GetCollection<Subject>(collectionName);
        }

        public async Task CreateSubjectAsync(Subject subject)
        {
            await subjectsCollection.InsertOneAsync(subject);
        }

        public async Task<Subject> GetSubjectAsync(Guid id)
        {
            var filter = filterBuilder.Eq(subject => subject.Id, id);
            return await subjectsCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<Subject> GetSubjectAsync(string name)
        {
            var filter = filterBuilder.Eq(subject => subject.Title, name);
            return await subjectsCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<IEnumerable<Subject>> GetSubjectsAsync()
        {
            return await subjectsCollection.Find(new BsonDocument()).ToListAsync();
        }
    }
}