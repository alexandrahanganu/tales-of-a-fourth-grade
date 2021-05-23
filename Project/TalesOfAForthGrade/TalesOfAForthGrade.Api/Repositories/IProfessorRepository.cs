using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Api.Repositories
{
    public interface IProfessorRepository
    {
        Task<IEnumerable<Professor>> GetProfessorsAsync();
        Task<Professor> GetProfessorAsync(Guid id);

        Task<Professor> GetProfessorAsync(string name);

        Task CreateProfessorAsync(Professor professor);

        Task UpdateProfessorAsync(Professor professor);

        void DeleteProfessorAsync(Guid id);
    }
}