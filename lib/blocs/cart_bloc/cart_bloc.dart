import 'package:bloc/bloc.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf_repository/pdf_repository.dart';
import 'package:pdf/widgets.dart' as pw;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(ICartRepository repository, IPDFRepository pdfRepository)
      : _repository = repository,
        _pdfRepository = pdfRepository,
        super(CartInitial()) {
    on<LoadCart>((event, emit) {
      _repository.getCart(id).then((value) {
        id = value.id!;
        _repository.getCartStream(id).listen((value) => add(CartReady(value)));
        add(CartReady(value));
      });
      emit(CartLoading());
    });
    on<CartReady>((event, emit) {
      emit(CartLoaded(event.cart));
    });
    on<UpdateCart>((event, emit) {
      _repository.updateCart(id, event.cart);
      emit(CartLoading());
    });
    on<GeneratePDF>((event, emit) {
      _pdfRepository
          .createPDF(event.content)
          .then((value) => OpenFile.open(value.path));
    });
  }
  late final ICartRepository _repository;
  late final IPDFRepository _pdfRepository;
  String id = '';
}
