import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Executive Board Member, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Create an Ideate Event', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/01_Create_Event.py')


if st.button('Get Details for a specific Ideate Event', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_Get_Specific_Event.py')

  
if st.button('Get Details for a specific Ideate Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/03_Get_Specific_Project.py')

if st.button('Get Projects Since September 2024',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/04_AfterSeptember1_Projects.py')

if st.button('Update an Ideate Event', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/05_Update_Event.py')