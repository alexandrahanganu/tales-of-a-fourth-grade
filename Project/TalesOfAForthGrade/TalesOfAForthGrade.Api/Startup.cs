using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Net.Http.Headers;
using Microsoft.OpenApi.Models;

using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.Serializers;
using MongoDB.Driver;

using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Api.Settings;

namespace TalesOfAForthGrade.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddCors(options =>
            {
                options.AddPolicy(name: "*",
                                builder =>
                                {
                                    builder.WithOrigins("https://localhost:5001",
                                                        "http://localhost:3333",
                                                        "*")
                                            .WithHeaders(HeaderNames.ContentType, HeaderNames.Authorization)
                                            .WithMethods("GET", "POST", "PUT", "DELETE", "OPTIONS");
                                });
            });

            BsonSerializer.RegisterSerializer(new GuidSerializer(BsonType.String));

            services.AddSingleton<IMongoClient>(ServiceProvider => {
               var settings = Configuration.GetSection(nameof(MongoDbSettings)).Get<MongoDbSettings>();
               return new MongoClient(settings.ConnectionString);
            });
            services.AddSingleton<IStudentsRepository, MongoDbStudentRepository>();
            services.AddSingleton<IProfessorRepository, MongoDbProfessorRepository>();
            services.AddSingleton<IGradesRepository, MongoDbGradesRepository>();
            services.AddSingleton<ISubjectsRepository, MongoDbSubjectRepository>();
            services.AddSingleton<IAbsensesRepository, MongoDbAbsensesRepository>();
            services.AddSingleton<IAssignmentsRepository, MongoDbAssignmentRepository>();

            services.AddControllers(options => {
                options.SuppressAsyncSuffixInActionNames = false;
            });
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "TalesOfAForthGrade", Version = "v1" });
            });

            services.AddAuthentication( auth=>
            {
                auth.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                auth.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(options =>    
            {    
                options.TokenValidationParameters = new TokenValidationParameters    
                {    
                    ValidateIssuer = true,    
                    ValidateAudience = true,    
                    ValidateLifetime = true,    
                    ValidateIssuerSigningKey = true,    
                    ValidIssuer = Configuration["Jwt:Issuer"],    
                    ValidAudience = Configuration["Jwt:Issuer"],    
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Key"]))    
                };    
            });

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "TalesOfAForthGrade v1"));
            }

            app.UseHttpsRedirection();

            app.UseAuthentication();
            app.UseRouting();
            app.UseCors("*");
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
