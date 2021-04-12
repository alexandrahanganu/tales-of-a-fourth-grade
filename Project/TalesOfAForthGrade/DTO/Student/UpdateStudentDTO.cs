

using System.ComponentModel.DataAnnotations;

namespace TalesOfAForthGrade.DTO.Student
{
    public record UpdateStudentDTO
    {
        [Required]
        [RegularExpression(@"[A-Z][a-z]{2,40}")]
        public string LastName { get; init; }

        [Required]
        [RegularExpression(@"[A-Z][a-z]{2,40}")]
        public string FirstName { get; init; }

        [Required]
        //[RegularExpression(@"[1-9][0-9]{2}(([0][0-1]|[1][0-2])([0-2][0-9]|[3][0-2])|([0][3-9]|[1][0-2])([0-2][0-9]|[3][0-2])|([0][2]|[1][0-2])([0-2][0-9]))[0-9]{6}")] // <- just for flexing
        [RegularExpression(@"[0-9]{13}")]
        public string CNP { get; init; }
    }
}