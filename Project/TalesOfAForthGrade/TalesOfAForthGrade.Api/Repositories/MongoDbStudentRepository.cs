using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using TalesOfAForthGrade.Api.Entities;

namespace TalesOfAForthGrade.Api.Repositories
{
    public class MongoDbStudentRepository : IStudentsRepository
    {

        private const string databaseName = "ToaFG";
        private const string collectionName = "students";
        private readonly IMongoCollection<Student> studentsCollection;
        private readonly FilterDefinitionBuilder<Student> filterBuilder = Builders<Student>.Filter;

        public MongoDbStudentRepository(IMongoClient mongoClient){
            IMongoDatabase database = mongoClient.GetDatabase(databaseName);
            studentsCollection = database.GetCollection<Student>(collectionName);
        }

        public async Task CreateStudentAsync(Student student)
        {
            await studentsCollection.InsertOneAsync(student);
        }

        public async void DeleteStudentAsync(Guid id)
        {
            var filter = filterBuilder.Eq(student => student.Id, id);
            await studentsCollection.DeleteOneAsync(filter);
        }

        public async Task<Student> GetStudentAsync(String cnp){
            var filter = filterBuilder.Eq(student => student.CNP, cnp);
            return await studentsCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<Student> GetStudentAsync(Guid id)
        {
            var filter = filterBuilder.Eq(student => student.Id, id);
            return await studentsCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<IEnumerable<Student>> GetStudentsAsync()
        {
            return await studentsCollection.Find(new BsonDocument()).ToListAsync();
        }

        public async Task UpdateStudentAsync(Student student)
        {
            var filter = filterBuilder.Eq(existingStudent => existingStudent.Id, student.Id);
            await studentsCollection.ReplaceOneAsync(filter, student);
        }
    }
}