using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Entities;
using Infrastructure.Extensions;
using Infrastructure.Repositories.Interfaces;
using Microsoft.Extensions.Configuration;

namespace Infrastructure.Repositories
{
    public class ProjectRepository : IProjectRepository
    {
        public string ConnectionString { get; }
        private readonly IConfiguration _configuration;

        public ProjectRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            ConnectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IEnumerable<Project>> FindAll()
        {
            return await this.FindAllAsync<Project>();
        }

        public async Task<IEnumerable<Project>> FindAllById(int projectId)
        {
            return await this.FindAllByIdAsync(projectId);
        }

        public async Task<Project> FindById(int projectId)
        {
            return await this.FindByIdAsync(projectId);
        }

        public async Task Add(Project project)
        {
            await this.AddAsync(project);
        }

        public async Task Update(Project project)
        {
            await this.UpdateAsync(project);
        }

        public async Task Delete(int projectId)
        {
            await this.DeleteAsync(projectId);
        }
    }
}
