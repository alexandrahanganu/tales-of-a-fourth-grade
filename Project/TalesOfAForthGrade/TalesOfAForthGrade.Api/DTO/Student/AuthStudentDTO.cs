namespace TalesOfAForthGrade.Api.DTO.Student
{
    public record AuthStudentDTO{
        public string CNP { get; init; }
        public string Password { get; init; }
    }
}