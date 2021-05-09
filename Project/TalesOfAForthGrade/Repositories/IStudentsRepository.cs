using System.Collections.Generic;
using System;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Repositories
{
    public interface IStudentsRepository
    {
        Task<Student> GetStudentAsync(Guid id);

        Task<Student> GetStudentAsync(String cnp);
        Task<IEnumerable<Student>> GetStudentsAsync();

        Task CreateStudentAsync(Student student);

        Task UpdateStudentAsync(Student student);

        void DeleteStudentAsync(Guid id);
    }
}