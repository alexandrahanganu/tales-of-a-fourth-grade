using System;
namespace TalesOfAForthGrade.Api.Entities
{
    public record Subject{
        public Guid Id { get; init; }
        public string Title { get; init; }

    }
}