from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

#------------------------------------------------------------
# Create a new Blueprint object, which is a collection of 
# routes.
members = Blueprint('members', __name__)


#------------------------------------------------------------
# gets all the events that are planned
@members.route('/events', methods=['GET'])
def get_events():

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT * FROM Event 
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

#------------------------------------------------------------
# gets all the group meetings that this member attends
@members.route('/groupmeeting/<memberId>', methods=['GET'])
def get_groupMeetings(memberId):
    cursor = db.get_db().cursor()
    query = '''SELECT * FROM Group_Meeting AS gm 
                   JOIN Member_Meeting AS mm ON gm.meeting_id = mm.meeting_id
                   JOIN General_Member AS genMem ON mm.member_id = genMem.member_id
                 WHERE genMem.member_id = {0}'''.format(memberId)
    cursor.execute(query)
    theData = cursor.fetchall()
    response = make_response(jsonify(theData))
    response.status_code = 200
    return response

#------------------------------------------------------------
# gets all the status updates for the projects for the given user
@members.route('/statusupdates/<userID>', methods=['GET'])
def get_StatusUpdates(userID):
    cursor = db.get_db().cursor()
    query = '''SELECT * FROM Status_Update AS su 
                   JOIN Project AS p ON su.project_id = p.project_id
                   JOIN Member_Project AS memProj ON p.project_id = memProj.project_id
                   JOIN General_Member as genMem ON memProj.member_id = genMem.member_id
                 WHERE genMem.member_id = {0}'''.format(userID)
    cursor.execute(query)
    theData = cursor.fetchall()
    response = make_response(jsonify(theData))
    response.status_code = 200
    return response

#------------------------------------------------------------
# allows for member to insert a status update for a project
@members.route('/statusupdates', methods=['POST'])
def add_new_status_update():
    the_data = request.json
    current_app.logger.info(the_data)

    description = the_data['update_description']
    date = the_data['update_dateTime']
    projectId = the_data['project_id']
    memberId = the_data['member_id']
    
    query = f'''
        INSERT INTO Status_Update (update_description,
                              update_dateTime,
                              project_id, 
                              member_id)
        VALUES ('{description}', '{date}', '{projectId}', {memberId})
    '''
    
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    response = make_response("Successfully added status update")
    response.status_code = 200
    return response

#------------------------------------------------------------
# allows for member to update the status of a ticket
@members.route('/tickets', methods=['PUT'])
def update_customer():
    ticket_info = request.json
    id = ticket_info('ticket_id')
    status = ticket_info['ticket_status']

    query = 'UPDATE Ticket SET ticket_status = %s where id = %s'
    data = (status, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'ticket updated!'

#------------------------------------------------------------
# allows for member to view all the projects they are assigned to
@members.route('/projects/{member_id}', methods=['GET'])
def get_projects(member_id):

    cursor = db.get_db().cursor()

    query = '''SELECT *
                    FROM Project p
                    JOIN Member_Project mp ON p.project_id = mp.project_id
                    JOIN General_Member gm ON mp.member_id = gm.member_id
                    WHERE gm.member_id = {0}'''.format(member_id)
    
    cursor.execute(query)
    theData = cursor.fetchall()
    response = make_response(jsonify(theData))
    response.status_code = 200
    return response
#------------------------------------------------------------
# allows for member to add themselves to a project
@members.route('/projects', methods=['POST'])
def add_to_project():
    the_data = request.json
    current_app.logger.info(the_data)

    member_id = the_data['member_id']
    project_id = the_data['project_id']
    query = f'''
        INSERT INTO Member_Project (member_id, project_id,)
        VALUES ('{member_id}', '{project_id}')
    '''
    
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    response = make_response("Successfully added member to project")
    response.status_code = 200
    return response

#------------------------------------------------------------
# allows for member to get the information of the clients they are working for
@members.route('/clients/{member_id}', methods=['GET'])
def get_clients(member_id):

    cursor = db.get_db().cursor()

    query = '''SELECT client_name, client_email
               FROM Client c
                    JOIN Project p ON c.client_id = p.client_id
                    JOIN Member_Project mp ON p.project_id = mp.project_id
                    JOIN General_Member gm ON mp.member_id = gm.member_id
                WHERE gm.member_id = {0}'''.format(member_id)
    
    cursor.execute(query)
    theData = cursor.fetchall()
    response = make_response(jsonify(theData))
    response.status_code = 200
    return response
