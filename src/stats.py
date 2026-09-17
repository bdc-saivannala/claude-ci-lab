def average(values):
    """Mean of values, or 0.0 for an empty list."""
    return sum(values) / len(values) if values else 0.0
