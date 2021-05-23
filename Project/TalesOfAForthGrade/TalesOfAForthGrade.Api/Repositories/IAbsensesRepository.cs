using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Api.Repositories
{
    public interface IAbsensesRepository
    {

        Task<Absence> GetAbsence(Guid absenceId);
        Task<IEnumerable<Absence>> GetAbsencesStudentAsync(Guid studentId);

        Task CreateAbsenceAsync(Absence absence);

        Task UpdateAbsenceAsync(Absence absence);
    }
}