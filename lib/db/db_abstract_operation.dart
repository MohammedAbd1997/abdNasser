abstract class DBAOperation<T> {

  /**
   * CRUD:
   * C => Create
   * R => Read
   * U => Update
   * D => Delete
   */

  Future<int> create(T object);

  Future<List<T>> read();

  Future<T?> show(int id);

  Future<bool> update(T object);

  Future<bool> delete(int id);
}