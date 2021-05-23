using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Api.Repositories
{
    public interface IGradesRepository
    {
        Task<Grade> GetGradeAsync(Guid id);

        Task<IEnumerable<Grade>> GetGradesStudentAsync(Guid studentId);

        Task<IEnumerable<Grade>> GetGradesAsync();

        Task CreateGradeAsync(Grade grade);

        Task UpdateGradeAsync(Grade grade);
    }
}