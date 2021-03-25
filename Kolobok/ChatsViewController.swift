//
//  ChatsViewController.swift
//  Kolobok
//
//  Created by Виктор Марусин on 09.12.2020.
//

import UIKit
import MessageKit
import AVFoundation

class ChatsViewController: MessagesViewController {
    
    let buttonOne = UIButton(title: "", titleColor: .white, backgroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.8), cornerRadius: 20)
    let buttonTwo = UIButton(title: "", titleColor: .white, backgroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.8), cornerRadius: 20)
    
    let labelOne = UILabel()
    let labelTwo = UILabel()
    
    var canvasView = UIImageView()
    let canvasImage = UIImage(named: "home.jpg")
    
 //   var player = AVAudioPlayer()
    
    var messages = [Message]()
    var messagesNew = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(Message(content: "",
                                sender: ded,
                                messageId: "0",
                                sentDate: Date(),
                                status: "next",
                                answerOne: "hello",
                                answerTwo: "hello",
                                transitionOne: 0,
                                transitionTwo: 0,
                                kind: .text("Испеки, старуха, колобок")))
        messages.append(Message(content: "",
                                sender: baba,
                                messageId: "1",
                                sentDate: Date(),
                                status: "question",
                                answerOne: "Попроси у соседки",
                                answerTwo: "По коробу поскреби, по сусекам помети",
                                transitionOne: 3,
                                transitionTwo: 2,
                                kind: .text("Из чего печь-то? Муки нету")))
        messages.append(Message(content: "",
                                sender: ded,
                                messageId: "2",
                                sentDate: Date(),
                                status: "answer",
                                answerOne: "",
                                answerTwo: "",
                                transitionOne: 0,
                                transitionTwo: 0,
                                kind: .text("Э-эх, старуха! По коробу поскреби, по сусекам помети; авось муки и наберется")))
        messages.append(Message(content: "",
                                sender: baba,
                                messageId: "3",
                                sentDate: Date(),
                                status: "answer",
                                answerOne: "",
                                answerTwo: "",
                                transitionOne: 0,
                                transitionTwo: 0,
                                kind: .text("Вот еще. Не буду я у нее ни чего просить. Лучше пойду по коробу поскребу, по сусекам помету; авось муки и наберу")))
        messages.append(Message(content: "",
                                sender: baba,
                                messageId: "4",
                                sentDate: Date(),
                                status: "answer",
                                answerOne: "",
                                answerTwo: "",
                                transitionOne: 0,
                                transitionTwo: 0,
                                kind: .text("Взяла старуха крылышко, по коробу поскребла, по сусеку помела, и набралось муки пригоршни с две. Замесила на сметане, изжарила в масле и положила на окошечко постудить.")))
        


        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

        view.backgroundColor = .systemGray6
        messagesCollectionView.backgroundColor = .systemGray6
        canvasView = UIImageView(image: canvasImage)
        messagesCollectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0) //делаем messagesCollectionView прозрачным что бы было видно фон
        view.contentMode = UIView.ContentMode.scaleAspectFill //делаем по центру картинку
        self.view.layer.contents = canvasImage?.cgImage
        
        configureMessageInputBar()
        setupConstraints()
        UserSettings.position = 0 //временно обнуляем текущую позицию чата
        checkPosition()
        
        let buttonInsidesOne = messages[1].answerOne
        let buttonInsidesTwo = messages[1].answerTwo

        buttonOne.setTitle("\(buttonInsidesOne)", for: .normal)
        buttonTwo.setTitle("\(buttonInsidesTwo)", for: .normal)
        buttonOne.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        buttonTwo.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        
        //        do {    //пытаемся загрузить
        //            if let audioPath = Bundle.main.path(forResource: "beep", ofType: "mp3") {// загружаем аудио файл
        //            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))// если загрузка прошла нормально
        //            }
        //        } catch { // если загрузить не удалось
        //            print ("Error")
        //        }
    }
    
    private func checkPosition() {
        if let positionNumber = UserSettings.position {
           
            for i in 0...positionNumber {
                //print("текущая позиция:\(positionNumber)")
                messagesNew.append(messages[i])
                messagesNew.sort()
                
                messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToLastItem(animated: true)
            }
        } else { return }
    }
    
    private func newSwitcherNavigation() {
        
    }
    
    
    private func switcherNavigation() {
        
        if  UserSettings.position < messages.count {
            UserSettings.position += 1
        } else {
            UserSettings.position = 0
        }
        
        for i in UserSettings.position...UserSettings.position {
            messagesNew.append(messages[i])
            messagesNew.sort()
            

//                DispatchQueue.main.asyncAfter(deadline: .now() + 200.0) { // Change `2.0` to the desired number of seconds.
//                   // Code you want to be delayed
//                }

            messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: true)
        }
    }
    
    @objc private func button1Tapped() {
        UserSettings.position = 0
    }
    
    @objc private func button2Tapped() {
        switcherNavigation()
    }
}

extension ChatsViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return ded
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        self.player.play()  //запускаем плеер
        return messagesNew[indexPath.item]
    }
    
    //кол-во отправленных сообщений
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messagesNew.count
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20 // отступ displayName от текста
    }
    
    // атрибуты displayName
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
         return NSAttributedString(
            string: message.sender.displayName,
            attributes:[.font: UIFont.boldSystemFont(ofSize: 12),
                        .foregroundColor: UIColor.white])
    }
}

// MARK:: - MessagesLayoutDelegate   задаем цветовую схему чата, аватары и т.д
extension ChatsViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.8) : #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1).withAlphaComponent(0.8) //здесь понимаем кто отправляет сообщение и назначаем каждой стороне свой цвет фона
    }

    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .white //здесь понимаем кто отправляет сообщение и назначаем каждой стороне свой цвет текста
    }

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft //хвостики для чата
        return .bubbleTail(corner, .curved) // здесь задаем стиль чата
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let desiredSize = CGSize(width: 38.0, height: 38.0)
        let person = personIco[message.sender.displayName]
        let newImage = person?.resizeUI(size: desiredSize)
        avatarView.frame.size = CGSize(width: 38, height: 38)
        avatarView.image = newImage
    }
}

// MARK:: - MessagesLayoutDelegate
extension ChatsViewController: MessagesLayoutDelegate {
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 1)  //здесь настраиваем промежутки между сообщениями
    }
}

//
//        configureMessageInputBar()
//        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout { //проверяем если сможем скастить то убираем отступ от экрана вместо аватарки
//            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
//            layout.photoMessageSizeCalculator.incomingAvatarSize = .zero
//            layout.photoMessageSizeCalculator.incomingAvatarSize = .zero
//        }
//

//        messageInputBar.delegate = self

//}
//
//// MARK: - ConfigureMessageInputBar  здесь задаем интерфейс оптравки сообщений
extension ChatsViewController {
    func configureMessageInputBar() {
        messageInputBar.isHidden = true //прячем InputBar пока не нужен
    }
}

//
////MARK:: - MessagesInputBarDelegate
//extension ChatsViewController: InputBarAccessoryViewDelegate {
//    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//        let message = MMessage(user: user, content: text)
//        FirestoreService.shared.sendMessage(chat: chat, message: message) { (result) in
//            switch result {
//                case .success():
//                    self.messagesCollectionView.scrollToBottom()// загружаем все сообщения ранее написанные и сместиля на самое последнее
//                case .failure(let error):
//                    self.showAlert(with: "Ошибка", and: error.localizedDescription)
//            }
//        }
//        inputBar.inputTextView.text = ""
//    }
//}
//
//extension ChatsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        //пытаемся вытащить изображение
//        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
//        sendImage(image: image)
//    }
//}
//

//фунация приема новых сообщений
//private func insertNewMessage(message: MMessage) {
//    // проверяем что уже массив сообщений не содержит нового сообщения
//    guard !messages.contains(message) else { return }
//    messages.append(message) //создаем новое сообщение
//    messages.sort()
//
//    //здесь проверяем не выходит ли за границы наше сообщение и если да то делает скролл вниз
//    let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
//    let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
//
//    messagesCollectionView.reloadData() //обновляем данные
//
//    //делаем это в асинхронном потоке что бы не поплыл интерфейс
//    if shouldScrollToBottom {
//        DispatchQueue.main.async {
//            self.messagesCollectionView.scrollToBottom(animated: true)
//        }
//    }
//}

extension ChatsViewController {
    private func setupConstraints() {
        buttonOne.heightAnchor.constraint(equalToConstant: 50).isActive = true //внутренняя высота кнопок
        buttonTwo.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let stackView = UIStackView(arrangedSubviews: [
            buttonOne,
            buttonTwo
            ],
                                    axis: .horizontal,
                                    spacing: 4) //расстояние между копками

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            buttonOne.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0), //отступ справа
            buttonOne.trailingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: -10),
            buttonTwo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0), // отстп слева
            buttonTwo.leadingAnchor.constraint(equalTo: buttonOne.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            messagesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            messagesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            messagesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64)
        ])
    }
}



