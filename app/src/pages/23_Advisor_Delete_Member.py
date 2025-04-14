import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Remove Member from Project ")




member_id = st.text_input("Enter Member ID to Remove Member:")
project_id = st.text_input("Enter Project ID:") 

if st.button("Remove Member"):
    if member_id and project_id:
        response = requests.delete(f"http://api:4000/a/member_project/{member_id}/{project_id}")
        if response.status_code == 200:
            response = "Member successfully removed."
            st.write(response)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please fill out all fields.")




