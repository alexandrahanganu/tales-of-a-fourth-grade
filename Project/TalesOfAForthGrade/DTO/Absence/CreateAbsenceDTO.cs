using System;

namespace TalesOfAForthGrade.DTO.Absence
{
    public record CreateAbsenceDTO{
        public Guid Student { get; init; }

        public DateTime Date {get; init;}
    }
}