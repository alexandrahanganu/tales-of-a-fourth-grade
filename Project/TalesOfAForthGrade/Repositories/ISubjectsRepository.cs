using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Repositories
{
    public interface ISubjectsRepository
    {
        Task<Subject> GetSubjectAsync(Guid id);

        Task<Subject> GetSubjectAsync(string name);

        Task<IEnumerable<Subject>> GetSubjectsAsync();

        Task CreateSubjectAsync(Subject subject);

    }
}