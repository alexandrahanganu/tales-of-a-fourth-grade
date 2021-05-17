using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Driver;
using TalesOfAForthGrade.Entities;

namespace TalesOfAForthGrade.Repositories
{
    public class MongoDbAssignmentRepository : IAssignmentsRepository
    {

        private const string databaseName = "ToaFG";
        private const string collectionName = "assignments";
        private readonly IMongoCollection<Assignment> assignmentsCollection;
        private readonly FilterDefinitionBuilder<Assignment> filterBuilder = Builders<Assignment>.Filter;

        public MongoDbAssignmentRepository(IMongoClient mongoClient){
            IMongoDatabase database = mongoClient.GetDatabase(databaseName);
            assignmentsCollection = database.GetCollection<Assignment>(collectionName);
        }

        public async Task CreateAssignmentAsync(Assignment assignment)
        {
            await assignmentsCollection.InsertOneAsync(assignment);
        }

        public async Task<Assignment> GetAssignmentAsync(Guid absenceId)
        {
            var filter = filterBuilder.Eq(absence => absence.Id, absenceId);
            return await assignmentsCollection.Find(filter).SingleOrDefaultAsync();
        }

        public async Task<IEnumerable<Assignment>> GetAssignmentsStudentAsync(Guid studentId)
        {
            var filter = filterBuilder.Eq(assignment => assignment.Student, studentId);
            return await assignmentsCollection.Find(filter).ToListAsync();
        }

        public async Task UpdateAssignmentsAsync(Assignment assignment)
        {
            var filter = filterBuilder.Eq(oldAssignment => oldAssignment.Id, assignment.Id);
            await assignmentsCollection.ReplaceOneAsync(filter, assignment);
        }

    }
}