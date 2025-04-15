from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

advisors = Blueprint('advisors', __name__)


# 3.6
@advisors.route('/proposal/<advisor_id>', methods=['GET'])
def get_proposal_by_id(advisor_id):
    current_app.logger.info("GET /proposal/<advisor_id> route")

    query = '''
        SELECT *
        FROM Proposal p
        WHERE advisor_id = {0}'''.format(advisor_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    data = cursor.fetchall()

    response = make_response(jsonify(data))
    response.status_code = 200
    return response

# 3.5
@advisors.route('/client/<client_id>', methods=['PUT'])
def update_client_email(client_id):
    updated_email = request.json.get('client_email')

    current_app.logger.info("PUT /a/client/<client_id> route")

    query = f'''
        UPDATE Client
        SET client_email = %s
        WHERE client_id = %s
    '''
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query, (updated_email, client_id))
    db.get_db().commit()

    response = make_response("Client email updated successfully.")
    response.status_code = 200
    return response

# 3.4
@advisors.route('/member_project/<member_id>/<project_id>', methods=['DELETE'])
def delete_member_project(member_id, project_id):
    current_app.logger.info("DELETE /a/member_project/<member_id>/<project_id> route")
    query = '''
        DELETE FROM Member_Project
        WHERE member_id = %s AND project_id = %s
    '''
    
    cursor = db.get_db().cursor()
    cursor.execute(query, (member_id, project_id))
    db.get_db().commit()

    response = make_response("Member-Project relation deleted successfully.")
    response.status_code = 200
    return response


# 3.2
@advisors.route('/officehours/', methods=['POST'])
def create_office_hours():
    session_info = request.json
    session_start_time = session_info['session_startTime']
    session_end_time = session_info['session_endTime']
    advisor_id = session_info['advisor_id']


    current_app.logger.info("POST /officehours/ route")

    query = '''
        INSERT INTO Office_Hours(session_startTime, session_endTime, advisor_id)
        VALUES (%s, %s, %s)
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query, (session_start_time, session_end_time, advisor_id))
    db.get_db().commit()

    response = make_response("Office hour session created successfully.")
    response.status_code = 200
    return response


# 3.1
@advisors.route('/projects', methods=['GET'])
def get_projects():
    current_app.logger.info("GET /a/projects route")

    query = '''
        SELECT p.project_id, p.project_description, c.client_name
        FROM Project p
        JOIN Client c ON p.client_id = c.client_id
        ORDER BY c.client_name
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query)
    data = cursor.fetchall()

    response = make_response(jsonify(data))
    response.status_code = 200
    return response


# create ticket
@advisors.route('/ticket/', methods=['POST'])
def create_ticket():
    ticket_info = request.json
    ticket_status = ticket_info['ticket_status']
    ticket_description = ticket_info['ticket_description']
    project_id = ticket_info['project_id']


    current_app.logger.info("POST /ticket/ route")

    query = '''
        INSERT INTO Ticket(ticket_status, ticket_description, project_id)
        VALUES (%s, %s, %s)
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query, (ticket_status, ticket_description, project_id))
    db.get_db().commit()

    response = make_response("Ticket created successfully.")
    response.status_code = 200
    return response
