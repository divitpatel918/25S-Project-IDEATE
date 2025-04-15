import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()


st.write("# About this App")

st.markdown (
    """
    This is an app for the Club Ideate to help each persona (Executive Members, Advisors, Clients, and General Members)

    The goal of this app is to centralize all the data that the club needs into one platform, allowing people to log in
    as these personas and view, update, or delete the necessary informationr regarding the projects, clients, and events
    the club takes on.
    """
        )

