using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Repositories
{
    public interface IAssignmentsRepository
    {

        Task<Assignment> GetAssignmentAsync(Guid absenceId);
        Task<IEnumerable<Assignment>> GetAssignmentsStudentAsync(Guid studentId);

        Task CreateAssignmentAsync(Assignment absence);

        Task UpdateAssignmentsAsync(Assignment absence);
    }
}