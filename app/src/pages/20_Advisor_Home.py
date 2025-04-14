import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Advisor, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View a Proposal', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/21_Advisor_Get_Proposal.py')

if st.button('Update Client Information', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/22_Advisor_Update_Client.py')

if st.button('Remove a Member from a Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/23_Advisor_Delete_Member.py')

if st.button('Create Office Hours Session', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/24_Advisor_Office_Hours.py')

if st.button('View Projects', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/25_Advisor_Get_Projects.py')