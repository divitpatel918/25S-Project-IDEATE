import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome General Member, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View all the Events for Ideate', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/11_Member_Events.py')

if st.button('View all Planned Group Meetings', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/12_Member_GroupMeetings.py')

if st.button('View all the Status Updates for a Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/13_Member_StatusUpdates.py')

if st.button('Insert Status Update for a Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/14_Member_PostStatusUpdate.py')

if st.button('Update Status of a Ticket', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/15_Member_Tickets.py')

if st.button('View all Projects Assigned', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/16_Member_SeeProjects.py')

if st.button('Add Yourself to a Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/17_Member_AddToProject.py')

if st.button('See the Client Information', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/18_Member_SeeClients.py')



