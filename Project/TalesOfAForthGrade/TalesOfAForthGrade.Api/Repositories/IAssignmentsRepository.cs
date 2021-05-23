using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Api.Repositories
{
    public interface IAssignmentsRepository
    {

        Task<Assignment> GetAssignmentAsync(Guid assignmentId);
        Task<IEnumerable<Assignment>> GetAssignmentsStudentAsync(Guid studentId);

        Task CreateAssignmentAsync(Assignment assignment);

        Task UpdateAssignmentsAsync(Assignment assignment);
    }
}