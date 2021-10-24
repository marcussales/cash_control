// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardController on _CardController, Store {
  final _$selectedCardAtom = Atom(name: '_CardController.selectedCard');

  @override
  CardModel get selectedCard {
    _$selectedCardAtom.reportRead();
    return super.selectedCard;
  }

  @override
  set selectedCard(CardModel value) {
    _$selectedCardAtom.reportWrite(value, super.selectedCard, () {
      super.selectedCard = value;
    });
  }

  final _$updateCardsAtom = Atom(name: '_CardController.updateCards');

  @override
  bool get updateCards {
    _$updateCardsAtom.reportRead();
    return super.updateCards;
  }

  @override
  set updateCards(bool value) {
    _$updateCardsAtom.reportWrite(value, super.updateCards, () {
      super.updateCards = value;
    });
  }

  final _$totalCardSpentsAtom = Atom(name: '_CardController.totalCardSpents');

  @override
  double get totalCardSpents {
    _$totalCardSpentsAtom.reportRead();
    return super.totalCardSpents;
  }

  @override
  set totalCardSpents(double value) {
    _$totalCardSpentsAtom.reportWrite(value, super.totalCardSpents, () {
      super.totalCardSpents = value;
    });
  }

  final _$selectedBankAtom = Atom(name: '_CardController.selectedBank');

  @override
  BankModel get selectedBank {
    _$selectedBankAtom.reportRead();
    return super.selectedBank;
  }

  @override
  set selectedBank(BankModel value) {
    _$selectedBankAtom.reportWrite(value, super.selectedBank, () {
      super.selectedBank = value;
    });
  }

  final _$averageValueAtom = Atom(name: '_CardController.averageValue');

  @override
  double get averageValue {
    _$averageValueAtom.reportRead();
    return super.averageValue;
  }

  @override
  set averageValue(double value) {
    _$averageValueAtom.reportWrite(value, super.averageValue, () {
      super.averageValue = value;
    });
  }

  final _$savingsValueAtom = Atom(name: '_CardController.savingsValue');

  @override
  double get savingsValue {
    _$savingsValueAtom.reportRead();
    return super.savingsValue;
  }

  @override
  set savingsValue(double value) {
    _$savingsValueAtom.reportWrite(value, super.savingsValue, () {
      super.savingsValue = value;
    });
  }

  final _$getCardsAsyncAction = AsyncAction('_CardController.getCards');

  @override
  Future<dynamic> getCards() {
    return _$getCardsAsyncAction.run(() => super.getCards());
  }

  final _$_CardControllerActionController =
      ActionController(name: '_CardController');

  @override
  CardModel selectCard(dynamic value) {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.selectCard');
    try {
      return super.selectCard(value);
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isUpdatingCards(dynamic value) {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.isUpdatingCards');
    try {
      return super.isUpdatingCards(value);
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isSelectedCard(dynamic card) {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.isSelectedCard');
    try {
      return super.isSelectedCard(card);
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  BankModel selectBank(dynamic value) {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.selectBank');
    try {
      return super.selectBank(value);
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  double updateAverageValue(dynamic value) {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.updateAverageValue');
    try {
      return super.updateAverageValue(value);
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetSelecteds() {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.resetSelecteds');
    try {
      return super.resetSelecteds();
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateSavingsValue() {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.updateSavingsValue');
    try {
      return super.updateSavingsValue();
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sumCardsSpents({List<CardModel> cards}) {
    final _$actionInfo = _$_CardControllerActionController.startAction(
        name: '_CardController.sumCardsSpents');
    try {
      return super.sumCardsSpents(cards: cards);
    } finally {
      _$_CardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCard: ${selectedCard},
updateCards: ${updateCards},
totalCardSpents: ${totalCardSpents},
selectedBank: ${selectedBank},
averageValue: ${averageValue},
savingsValue: ${savingsValue}
    ''';
  }
}
