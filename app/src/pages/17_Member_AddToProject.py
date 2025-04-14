import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from modules.nav import SideBarLinks

SideBarLinks()

with st.form("Add Yourself to Project"):
    memberId = st.text_input("Input Member Id")
    projectId = st.text_input("Input Project Id:")

    submitted = st.form_submit_button
    if submitted:
        data = {}
        data['member_id'] = memberId
        data['project_id'] = projectId
        st.write(data)

        requests.post('http://api:4000/m/projects', json = data)

    