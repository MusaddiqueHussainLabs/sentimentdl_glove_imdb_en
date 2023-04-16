from src.models.train_model import TrainPipeline
from src.models.predict_model import PredictPipeline

if __name__=="__main__":
    # _train_pipeline = TrainPipeline()
    # _train_pipeline.train()

    # _predict_pipeline = PredictPipeline()
    # _predict_pipeline.predict()

    _predict_pipeline = PredictPipeline()
    unseen_reviews = ["The room was great, but the staff was unfriendly.","this is very bad movie"]
    result = _predict_pipeline.full_annotate(unseen_reviews)
    print(result)