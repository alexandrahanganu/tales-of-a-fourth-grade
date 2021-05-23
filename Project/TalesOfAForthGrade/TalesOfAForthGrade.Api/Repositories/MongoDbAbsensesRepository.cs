using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using TalesOfAForthGrade.Api.Entities;

namespace TalesOfAForthGrade.Api.Repositories
{
    public class MongoDbAbsensesRepository : IAbsensesRepository
    {

        private const string databaseName = "ToaFG";
        private const string collectionName = "abseces";
        private readonly IMongoCollection<Absence> absensesCollection;
        private readonly FilterDefinitionBuilder<Absence> filterBuilder = Builders<Absence>.Filter;

        public MongoDbAbsensesRepository(IMongoClient mongoClient){
            IMongoDatabase database = mongoClient.GetDatabase(databaseName);
            absensesCollection = database.GetCollection<Absence>(collectionName);
        }

        public async Task CreateAbsenceAsync(Absence absence)
        {
            await absensesCollection.InsertOneAsync(absence);
        }

        public async Task<Absence> GetAbsence(Guid absenceId)
        {
            var filter = filterBuilder.Eq(absence => absence.Id, absenceId);
            return await absensesCollection.Find(filter).SingleOrDefaultAsync();
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