using System;
using MongoDB.Driver;

namespace TalesOfAForthGrade.DTO.Grade
{
    public record UpdateGradeDTO{
        public int Value { get; init; }
        
    }
}