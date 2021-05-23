using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Api.Repositories
{
    public interface ISubjectsRepository
    {
        Task<Subject> GetSubjectAsync(Guid id);

        Task<Subject> GetSubjectAsync(string name);

        Task<IEnumerable<Subject>> GetSubjectsAsync();

        Task CreateSubjectAsync(Subject subject);

    }
}