using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using TalesOfAForthGrade.Api.Entities;

namespace TalesOfAForthGrade.Api.Repositories
{
    public class MongoDbProfessorRepository : IProfessorRepository
    {

        private const string databaseName = "ToaFG";
        private const string collectionName = "professors";
        private readonly IMongoCollection<Professor> professorsCollection;
        private readonly FilterDefinitionBuilder<Professor> filterBuilder = Builders<Professor>.Filter;

        public MongoDbProfessorRepository(IMongoClient mongoClient){
            IMongoDatabase database = mongoClient.GetDatabase(databaseName);
            professorsCollection = database.GetCollection<Professor>(collectionName);
        }

        public async Task CreateProfessorAsync(Professor professor)
        {
            await professorsCollection.InsertOneAsync(professor);
        }

        public async void DeleteProfessorAsync(Guid id)
        {
            var filter = filterBuilder.Eq(prof => prof.Id, id);
            await professorsCollection.DeleteOneAsync(filter);
        }

        public async Task<Professor> GetProfessorAsync(string name){
            var filter = filterBuilder.Eq(prof => prof.username, name);
            return await professorsCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<Professor> GetProfessorAsync(Guid id)
        {
            var filter = filterBuilder.Eq(professor => professor.Id, id);
            return await professorsCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<IEnumerable<Professor>> GetProfessorsAsync()
        {
            return await professorsCollection.Find(new BsonDocument()).ToListAsync();
        }

        public async Task UpdateProfessorAsync(Professor professor)
        {
            var filter = filterBuilder.Eq(existingProfessor => existingProfessor.Id, professor.Id);
            await professorsCollection.ReplaceOneAsync(filter, professor);
        }
    }
}