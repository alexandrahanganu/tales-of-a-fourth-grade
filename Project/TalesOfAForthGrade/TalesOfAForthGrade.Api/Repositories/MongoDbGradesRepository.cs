using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using TalesOfAForthGrade.Api.Entities;

namespace TalesOfAForthGrade.Api.Repositories
{
    public class MongoDbGradesRepository : IGradesRepository
    {

        private const string databaseName = "ToaFG";
        private const string collectionName = "grades";
        private readonly IMongoCollection<Grade> gradesCollection;
        private readonly FilterDefinitionBuilder<Grade> filterBuilder = Builders<Grade>.Filter;

        public MongoDbGradesRepository(IMongoClient mongoClient){
            IMongoDatabase database = mongoClient.GetDatabase(databaseName);
            gradesCollection = database.GetCollection<Grade>(collectionName);
        }

        public async Task CreateGradeAsync(Grade grade)
        {
            await gradesCollection.InsertOneAsync(grade);
        }

        public async Task<Grade> GetGradeAsync(Guid id)
        {
            var filter = filterBuilder.Eq(grade => grade.Id, id);
            return await gradesCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<IEnumerable<Grade>> GetGradesAsync()
        {
            return await gradesCollection.Find(new BsonDocument()).ToListAsync();
        }

        public async Task<IEnumerable<Grade>> GetGradesStudentAsync(Guid studentId)
        {
            var filter = filterBuilder.Eq(grade => grade.Student, studentId);
            return await gradesCollection.Find(filter).ToListAsync();
        }

        public async Task UpdateGradeAsync(Grade grade)
        {
            var filter = filterBuilder.Eq(oldGrade => oldGrade.Id, grade.Id);
            await gradesCollection.ReplaceOneAsync(filter, grade);
        }
    }
}