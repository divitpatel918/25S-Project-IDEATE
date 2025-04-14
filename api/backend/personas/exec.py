from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

executives = Blueprint('executives', __name__)


# user story 1.1 (create event)
@executives.route('/events', methods=['POST'])
def add_new_event():

    the_data = request.json
    current_app.logger.info(the_data)

    # extracting the variable
    title = the_data['event_title']
    start_time = the_data['event_startTime']
    end_time = the_data['event_endTime']
    num_rsvps = the_data['num_RSVPS']
    exec_id = the_data['exec_id']
    speaker_id = the_data['speaker_id']
    
    query = f'''
        INSERT INTO Event (event_title,
                              event_startTime, 
                              event_endTime,
                              num_RSVPS,
                              exec_id,
                              speaker_id)
        VALUES ('{title}', '{start_time}', '{end_time}', {str(num_rsvps)}, {str(exec_id)}, {str(speaker_id)})
    '''
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    response = make_response("Successfully added event.")
    response.status_code = 200
    return response


# user story 1.2  (get information about a specific event)
@executives.route('/events/<event_id>', methods=['GET'])
def get_event(event_id):
    current_app.logger.info('GET /events/<event_id> route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT event_title, num_RSVPS FROM Events WHERE event_id = {0}'.format(event_id))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


# user story 1.3 (get information about a specific project)
@executives.route('/projects/<project_id>', methods=['GET'])
def get_projects(project_id):
    current_app.logger.info('GET /projects/<project_id> route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT p.project_id AS project_id, p.project_description AS description FROM Project p WHERE p.project_id = {0}'.format(project_id))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response



# user story 1.4 (get clients and projects that started on April 1)
@executives.route('/clients', methods=['GET'])
def get_clients():

    cursor = db.get_db().cursor()
    cursor.execute('''
                   
    SELECT c.client_name AS client, p.project_description AS project
    FROM Client c
    JOIN Project p ON c.client_id = p.client_id
    WHERE p.project_startDate = ‘2025-04-01’

    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    the_response.mimetype='application/json'
    return the_response


# user story 1.6 (update event title, starttime, and endtime)
@executives.route('/events/<event_id>', methods=['PUT'])
def update_event():
    current_app.logger.info('PUT /events/<event_id> route')

    the_data = request.json
    current_app.logger.info(the_data)

    event_id = the_data['event_id']
    title = the_data['event_title']
    start_time = the_data['event_startTime']
    end_time = the_data['event_endTime']

    query = 'UPDATE Event SET first_name = %s, last_name = %s, company = %s WHERE event_id = %s'
    data = (title, start_time, end_time, event_id)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'event updated!'