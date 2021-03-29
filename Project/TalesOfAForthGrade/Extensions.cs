using TalesOfAForthGrade.DTO;
using TalesOfAForthGrade.Entities;

namespace TalesOfAForthGrade
{
    public static class Extensions{
        public static StudentDTO AsDto(this Student student){
            return new StudentDTO{
                //Id = student.Id,
                FirstName = student.FirstName,
                LastName = student.LastName,
                //CNP = student.CNP
            };
        }
    }
}