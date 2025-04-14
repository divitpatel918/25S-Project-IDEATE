
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

clients = Blueprint('clients', __name__)




# user story 1
@clients.route('/statusupdate/<project_id>', methods=['GET'])
def get_statusupdate(project_id):
    current_app.logger.info('GET /statusupdate/<project_id> route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Status_Update WHERE project_id = {0}'.format(project_id))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


#user story 2 

@clients.route('/project/<project_id>', methods = ['PUT'])
def put_project(project_id):
    current_app.logger.info('PUT /project/<project_id> route')

    the_data = request.json
    current_app.logger.info(the_data)

    
    description = the_data['project_description']
    


    query = 'UPDATE Project SET project_description = %s, project_startDate = %s, project_endDate = %s WHERE project_ID = %s'
    data = (description, project_id)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'project updated!'


#user story 3 

@clients.route('/projects/<client_id>/<project_id>', methods = ['DELETE'])
def delete_project(client_id, project_id):
    current_app.logger.info('DELETE /projects/<clients_id>/<project_id> route')

    cursor = db.get_db().cursor()
    query = 'DELETE FROM Project WHERE client_id =%s AND project_id = %s' 
    data = (client_id, project_id)
    cursor.execute(query, data)
    db.get_db().commit()
    return 'project deleted!'




#user story 4 
@clients.route('/memberproject/<project_id>', methods=['GET'])
def get_member_info(project_id):
    current_app.logger.info('GET /memberproject/<project_id> route')
    cursor = db.get_db().cursor()

    cursor.execute('''
        SELECT gm.member_id, gm.member_name, gm.member_email, gm.member_year, gm.member_major
        FROM General_Member gm
        JOIN Member_Project mp ON gm.member_id = mp.member_id
        WHERE mp.project_id = %s
    ''', (project_id,))

    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.mimetype='application/json'
    the_response.status_code = 200
    return the_response


# user story 5 
@clients.route('/executivemember/<client_id>', methods=['GET'])
def get_executive_member(client_id):
    current_app.logger.info('GET /executivemember/<client_id> route')
    cursor = db.get_db().cursor()

    cursor.execute('''
                   
    SELECT em.exec_id, em.exec_name, em.exec_email, em.exec_gradYear, em.exec_position
        FROM Executive_Member em
        JOIN Member_Project mp ON em.exec_id = mp.member_id
        JOIN Project p ON mp.project_id = p.project_id
        WHERE p.client_id = %s
    ''', (client_id))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

