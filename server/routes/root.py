from flask_restx import Resource, Namespace
import platform
import psutil

root_namespace = Namespace(
    name='root',
    description='Namespace for root endpoints'
)


@root_namespace.route('/health')
class Health(Resource):
    def get(self):
        """
        Health check
        """
        return 'OK', 200


@root_namespace.route('/info')
class Info(Resource):
    def get(self):
        """
        Retrieve information about the server
        """
        uname = platform.uname()
        cpu_percent = psutil.cpu_percent()
        virtual_memory = psutil.virtual_memory()
        disk_usage = psutil.disk_usage('/')

        return {
            'system': {
                'system_name': uname.system,
                'node_name': uname.node,
                'release': uname.release,
                'version': uname.version,
                'machine': uname.machine,
                'processor': uname.processor,
            },
            'cpu_percent': cpu_percent,
            'memory': {
                'total': virtual_memory.total,
                'available': virtual_memory.available,
                'used': virtual_memory.used,
                'percent': virtual_memory.percent
            },
            'disk': {
                'total': disk_usage.total,
                'used': disk_usage.used,
                'free': disk_usage.free,
                'percent': disk_usage.percent
            }
        }, 200
