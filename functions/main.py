import datetime
import firebase_admin
from firebase_admin import credentials, firestore, messaging

from firebase_functions.firestore_fn import (
    on_document_updated,
    Event,
    Change,
    DocumentSnapshot,
)

# Firebase 프로젝트 키 다운로드 및 경로 지정
# cred = credentials.Certificate(r'C:\ORM_CAMP\project_super.team\google-services.json')
firebase_admin.initialize_app()

# Firestore 초기화
db = firestore.client()


# 푸시 알림을 보내는 로직을 추가 (Firebase Cloud Messaging 사용)
def send_push_notification(user_token, message):
    # 푸시 알림 메시지 구성
    push_message = messaging.Message(
        notification=messaging.Notification(
            title='Uribingo - 알림',
            body=message
        ),
        token=user_token
    )

    try:
        # FCM을 사용하여 푸시 알림 전송
        response = messaging.send(push_message)
        print('Successfully sent message:', response)
        return 'Success', 200
    except Exception as e:
        print('Error sending message:', str(e))
        return 'Error', 500


@on_document_updated(document="foodDetails/{impend}")
def check_due_dates():
    # Firestore에서 냉장고, 음식 정보 가져오기

    food_collection = db.collection('foodDetails')
    all_foods = food_collection.stream()

    refrige_collection = db.collection('refrigeDetails')
    all_refriges = refrige_collection.stream()

    # 현재 시간
    current_time = datetime.datetime.now()

    for food in all_foods:
        # 문서 이름
        document_id = food.id

        # 문서 내의 필드 값
        food_image = food.get('foodImage')
        refrige_name = food.get('refrigeName')
        register_date = food.get('registerDate')
        extended = food.get('isExtended')
        public = food.get('isPublic')
        user_name = food.get('userName')
        user_token = food.get('userToken')

        for refrige in all_refriges:
            extension_period = 0
            period = 0
            if refrige_name == refrige.get('refrigeName'):
                period = refrige.get('period')
                if extended:
                    extension_period = refrige.get('extentionPeriod')
                else:
                    extension_period = 0

            # 남은 날짜 계산 (공용 음식은 제외)
            if not public:
                due_date_timestamp = register_date + (
                        period + extension_period) * 24 * 60 * 60 * 1000
                due_date = datetime.datetime.utcfromtimestamp(due_date_timestamp / 1000)
                remaining_days = (due_date - current_time).days

                if remaining_days <= 1:
                    # 푸시 알림 메시지 작성
                    message = f'{user_name}님의 보관음식 중 곧 폐기될 음식이 있습니다!'
                    # 푸시 알림 보내기
                    send_push_notification(user_token, message)
            if public:
                return

    print("Done")

# Cloud Functions 배포를 위한 명령어
# gcloud functions deploy check_due_dates --runtime python310 --trigger-event providers/cloud.firestore/eventTypes/document.create --trigger-resource "projects/YOUR_PROJECT_ID/databases/(default)/documents/books/{bookId}"
