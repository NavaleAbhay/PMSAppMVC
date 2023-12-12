// using System;
// using System.Collections.Generic;
// using System.Linq;
// using System.Threading.Tasks;
// using UnitOfWorkRepo.Domain.Interfaces;
// using MySql.Data.MySqlClient;

// namespace PMSApp.Domain.Entities
// {
//     public class UnitOfWork:IUnitOfWork
//     {
//     private readonly MySqlConnection _connection;
//     private MySqlTransaction _transaction;
//     private readonly Dictionary<Type, object> _repositories;

//     public UnitOfWork(string connectionString)
//     {
//         _connection = new SqlConnection(connectionString);
//         _connection.Open();
//         _transaction = _connection.BeginTransaction();
//         _repositories = new Dictionary<Type, object>();
//     }

//       public void SaveChanges()
//     {
//         _transaction.Commit();
//         _transaction = _connection.BeginTransaction();
//     }

//     public void RollBack()
//     {
//         _transaction.RollBack();
//         _transaction = _connection.BeginTransaction();
//     }
//     public void Dispose()
//     {
//         _transaction.Dispose();
//     }
//     }
// }