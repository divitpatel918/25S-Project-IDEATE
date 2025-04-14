import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from modules.nav import SideBarLinks

SideBarLinks()

with st.form("Create a Status Update"):
    status_description = st.text_input("Input Status Update Description:")
    status_date = st.text_input("Input Status Update Datetime:")
    status_projectId = st.text_input("Input Project Id:")
    status_memberId = st.text_input("Input Member Id")

    submitted = st.form_submit_button("Submit:")
    if submitted:
        data = {}
        data['update_description'] = status_description
        data['update_dateTime'] = status_date
        data['project_id'] = status_projectId
        data['member_id'] = status_memberId
        st.write("Status Update Created")
        st.write(data)

        requests.post('http://api:4000/m/statusupdates', json = data)

    