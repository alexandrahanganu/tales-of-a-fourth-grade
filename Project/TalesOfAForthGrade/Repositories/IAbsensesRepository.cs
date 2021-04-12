using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Repositories
{
    public interface IAbsensesRepository
    {

        Task<IEnumerable<Absence>> GetAbsencesStudentAsync(Guid studentId);

        Task CreateAbsenceAsync(Absence absence);

        Task UpdateAbsenceAsync(Absence absence);
    }
}