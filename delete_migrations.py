import os
import glob

def delete_all_migrations():
    # Obtiene la ruta raíz del proyecto
    project_root = os.path.dirname(os.path.abspath(__file__))

    # Busca en cada directorio las carpetas de migraciones
    for root, dirs, files in os.walk(project_root):
        if 'migrations' in dirs:
            migration_dir = os.path.join(root, 'migrations')
            
            # Borra todos los archivos .py dentro de la carpeta 'migrations', excepto __init__.py
            for migration_file in glob.glob(os.path.join(migration_dir, '*.py')):
                if '__init__.py' not in migration_file:
                    print(f'Deleting: {migration_file}')
                    os.remove(migration_file)
            
            # También elimina los archivos .pyc
            for migration_file in glob.glob(os.path.join(migration_dir, '*.pyc')):
                print(f'Deleting: {migration_file}')
                os.remove(migration_file)

if __name__ == "__main__":
    delete_all_migrations()
