namespace TalesOfAForthGrade.Api.DTO.Professor
{
    public record CreateProfessorDTO{
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public string Subject { get; init; }
    }
}