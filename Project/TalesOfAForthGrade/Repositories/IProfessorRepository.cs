using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Repositories
{
    public interface IProfessorRepository
    {
        Task<Professor> GetProfessorAsync(Guid id);

        Task<Professor> GetProfessorAsync(string name);

        Task CreateProfessorAsync(Professor professor);

        Task UpdateProfessorAsync(Professor professor);
    }
}