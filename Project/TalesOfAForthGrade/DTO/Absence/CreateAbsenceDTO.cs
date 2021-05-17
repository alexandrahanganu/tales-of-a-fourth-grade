using System;

namespace TalesOfAForthGrade.DTO.Absence
{
    public record CreateAbsenceDTO{
        public Guid Student { get; init; }

        public DateTimeOffset Date {get; init;}
    }
}