using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using TalesOfAForthGrade.Entities;

namespace TalesOfAForthGrade.Repositories
{
    public class MongoDbAbsensesRepository : IAbsensesRepository
    {

        private const string databaseName = "ToaFG";
        private const string collectionName = "absenses";
        private readonly IMongoCollection<Absence> absensesCollection;
        private readonly FilterDefinitionBuilder<Absence> filterBuilder = Builders<Absence>.Filter;

        public MongoDbAbsensesRepository(IMongoClient mongoClient){
            IMongoDatabase database = mongoClient.GetDatabase(databaseName);
            absensesCollection = database.GetCollection<Absence>(collectionName);
        }

        public async Task CreateAbsenceAsync(Absence absense)
        {
            await absensesCollection.InsertOneAsync(absense);
        }

        public async Task<IEnumerable<Absence>> GetAbsencesStudentAsync(Guid studentId)
        {
            var filter = filterBuilder.Eq(absence => absence.Student, studentId);
            return await absensesCollection.Find(filter).ToListAsync();
        }

        public async Task UpdateAbsenceAsync(Absence absence)
        {
            var filter = filterBuilder.Eq(oldAbsense => oldAbsense.Id, absence.Id);
            await absensesCollection.ReplaceOneAsync(filter, absence);
        }
    }
}