from src.users import get_user
from src.stats import average

def user_score(conn, request):
    return average(get_user(conn, request.args.get("name"))["scores"])
