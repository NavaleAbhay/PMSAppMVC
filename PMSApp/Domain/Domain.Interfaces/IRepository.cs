using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
// using Domain.Entities;

namespace Domain.Interfaces;
public interface IRepository<T> where T : class
{
    string ConnectionString{get;}
    Task<IEnumerable<T>> FindAll();
    Task<IEnumerable<T>> FindAllById(int id);
    Task<T> FindById(int id);
    Task Add(T entity);
    Task Delete(int id);
    Task Update(T entity);
}

