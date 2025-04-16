import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Client, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Get Information on Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/31_Client_Get_info.py')

if st.button('Update Project Description', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/32_change_desc_project.py')

if st.button('Delete Project Request', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/33_delete_project.py')

if st.button('Get all Members Working on Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/34_get_member_info.py')

if st.button('Get all Executives Working on Project', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/35_get_exec_info.py')